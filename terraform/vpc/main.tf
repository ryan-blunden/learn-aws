# ---------------------------------------------------------------------------------------------------------------------
# VPC
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_vpc" "${var.vpc_name}" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.vpc_name}"
  }
}

# We don't use the "Main" route table to avoid confusion with implicitly assigned subnets.
# Exolicit is better than implicit.
resource "aws_default_route_table" "r" {
  default_route_table_id = "${aws_vpc.cwc-dev.default_route_table_id}"

  tags {
    Name = "main-route-table-not-used"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# INTERNET GATEWAY
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_internet_gateway" "${var.igw_name}" {
  vpc_id = "${aws_vpc.cwc-dev.id}"

  tags {
    Name = "${var.igw_name}"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# NAT GATEWAY
# Includes the required creation of an Elastic IP.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_eip" "cwc-ngw-eip" {
  vpc = true
}

resource "aws_nat_gateway" "cwc-ngw" {
  allocation_id = "${aws_eip.cwc-ngw-eip.id}"
  subnet_id     = "${aws_subnet.ap-southeast-2a-public.id}"

  tags {
    Name = "cwc-ngw"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# PUBLIC SUBNETS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "ap-southeast-2a-public" {
  vpc_id = "${aws_vpc.cwc-dev.id}"
  cidr_block = "${var.public_subnet_cidrs["a"]}"
  availability_zone = "${var.us_west_2_azs["a"]}"

  tags {
    Name = "cwc-public-subnet-2a"
  }
}

resource "aws_subnet" "ap-southeast-2b-public" {
  vpc_id = "${aws_vpc.cwc-dev.id}"
  cidr_block = "${var.public_subnet_cidrs["b"]}"
  availability_zone = "${var.us_west_2_azs["b"]}"

  tags {
    Name = "cwc-public-subnet-2b"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# ROUTE TABLE FOR PUBLIC SUBNETS
# Add a public gateway to the public route table and associate the two public subnets.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table" "cwc-route-table-public" {
  vpc_id = "${aws_vpc.cwc-dev.id}"

  tags {
    Name = "cwc-route-table-public"
  }
}

resource "aws_route" "cwc-public-igw-route" {
  route_table_id = "${aws_route_table.cwc-route-table-public.id}"
  depends_on = ["aws_route_table.cwc-route-table-public"]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.cwc-igw.id}"
}

resource "aws_route_table_association" "ap-southeast-2a-public" {
  subnet_id = "${aws_subnet.ap-southeast-2a-public.id}"
  route_table_id = "${aws_route_table.cwc-route-table-public.id}"
}

resource "aws_route_table_association" "ap-southeast-2b-public" {
  subnet_id = "${aws_subnet.ap-southeast-2b-public.id}"
  route_table_id = "${aws_route_table.cwc-route-table-public.id}"
}


# ---------------------------------------------------------------------------------------------------------------------
# PRIVATE SUBNETS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "ap-southeast-2a-private" {
  vpc_id = "${aws_vpc.cwc-dev.id}"
  cidr_block = "${var.private_subnet_cidrs["a"]}"
  availability_zone = "${var.us_west_2_azs["a"]}"

  tags {
    Name = "cwc-private-subnet-2a"
  }
}

resource "aws_subnet" "ap-southeast-2b-private" {
  vpc_id = "${aws_vpc.cwc-dev.id}"
  cidr_block = "${var.private_subnet_cidrs["b"]}"
  availability_zone = "${var.us_west_2_azs["b"]}"

  tags {
    Name = "cwc-private-subnet-2b"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# ROUTE TABLE FOR PRIVATE SUBNETS
# Add a the NAT gateway to the private route table and associate the two private subnets.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table" "cwc-route-table-private" {
  vpc_id = "${aws_vpc.cwc-dev.id}"

  tags {
    Name = "cwc-route-table-private"
  }
}

resource "aws_route" "cwc-private-ngw-route" {
  route_table_id = "${aws_route_table.cwc-route-table-private.id}"
  depends_on = ["aws_route_table.cwc-route-table-private"]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.cwc-ngw.id}"
}

resource "aws_route_table_association" "ap-southeast-2a-private" {
  subnet_id = "${aws_subnet.ap-southeast-2a-private.id}"
  route_table_id = "${aws_route_table.cwc-route-table-private.id}"
}

resource "aws_route_table_association" "ap-southeast-2b-private" {
  subnet_id = "${aws_subnet.ap-southeast-2b-private.id}"
  route_table_id = "${aws_route_table.cwc-route-table-private.id}"
}
