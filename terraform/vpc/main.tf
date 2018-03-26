# ---------------------------------------------------------------------------------------------------------------------
# VPC
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_vpc" "resource" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.vpc_name}"
  }
}

# We don't use the "Main" route table to avoid confusion with implicitly assigned subnets.
# Exolicit is better than implicit.
resource "aws_default_route_table" "resource" {
  default_route_table_id = "${aws_vpc.resource.default_route_table_id}"

  tags {
    Name = "${var.vpc_name}-ig-main-route-table-not-used"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# INTERNET GATEWAY
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_internet_gateway" "resource" {
  vpc_id = "${aws_vpc.resource.id}"

  tags {
    Name = "${var.vpc_name}-ig"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# PUBLIC SUBNETS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "public" {
  count = "${length(var.availability_zones[var.aws_region])}"

  vpc_id = "${aws_vpc.resource.id}"
  cidr_block = "${element(var.public_subnet_cidrs, count.index)}"
  availability_zone = "${element(var.availability_zones[var.aws_region], count.index)}"

  tags {
    Name = "${var.vpc_name}-public-${element(var.availability_zones[var.aws_region], count.index)}"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# ROUTE TABLE FOR PUBLIC SUBNETS
# Add a public gateway to the public route table and associate the two public subnets.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.resource.id}"

  tags {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route" "public" {
  depends_on = ["aws_route_table.public"]
  route_table_id = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.resource.id}"
}

resource "aws_route_table_association" "public" {
  depends_on = ["aws_subnet.public"]
  count = "${aws_subnet.public.count}"

  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}


# ---------------------------------------------------------------------------------------------------------------------
# PRIVATE SUBNETS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "private" {
  count = "${length(var.availability_zones[var.aws_region])}"

  vpc_id = "${aws_vpc.resource.id}"
  cidr_block = "${element(var.private_subnet_cidrs, count.index)}"
  availability_zone = "${element(var.availability_zones[var.aws_region], count.index)}"

  tags {
    Name = "${var.vpc_name}-private-${element(var.availability_zones[var.aws_region], count.index)}"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# ROUTE TABLE FOR PRIVATE SUBNETS
# Add a the NAT gateway to the private route table and associate the two private subnets.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.resource.id}"

  tags {
    Name = "${var.vpc_name}-private-rt"
  }
}

resource "aws_route" "private" {
  depends_on = ["aws_route_table.private"]
  route_table_id = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.resource.id}"
}

resource "aws_route_table_association" "private" {
  depends_on = ["aws_subnet.private"]
  count = "${aws_subnet.private.count}"

  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# NAT GATEWAY
# Includes the required creation of an Elastic IP.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_eip" "resource" {
  vpc = true
}

resource "aws_nat_gateway" "resource" {
  allocation_id = "${aws_eip.resource.id}"
  subnet_id     = "${aws_subnet.public.0.id}"

  tags {
    Name = "${var.vpc_name}-ngw"
  }
}