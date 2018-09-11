#! /usr/bin/env python3
import datetime
import json
from dataclasses import dataclass
from http.server import BaseHTTPRequestHandler, HTTPServer

import pystache
from ec2_metadata import ec2_metadata


class SETTINGS:
    HOST: str = '0.0.0.0'
    PORT: int = 80
    HEALTHY: bool = True


@dataclass
class HTTPResponse:
    content: str
    status: int = 200
    content_type: str = 'application/json'


def index() -> HTTPResponse:
    content = pystache.render(open('content/index.html').read(), {
        'hostname': ec2_metadata.private_hostname,
        'ip': ec2_metadata.private_ipv4,
        'time': datetime.datetime.utcnow(),
        'health': SETTINGS.HEALTHY
    })

    return HTTPResponse(content=content, content_type='text/html')


def healthz() -> HTTPResponse:
    if SETTINGS.HEALTHY:
        return HTTPResponse(content=json.dumps({'status': 'ok'}))

    return HTTPResponse(content=json.dumps({'status': 'unhealthy'}), status=503)


def switch_health_status() -> HTTPResponse:
    SETTINGS.HEALTHY = not SETTINGS.HEALTHY
    return HTTPResponse(content=json.dumps({'new_health_status': SETTINGS.HEALTHY}))


def _404():
    return HTTPResponse(content=json.dumps({'error': 'not found'}), status=404)


def _500(error: str):
    return HTTPResponse(content=json.dumps({'error': error}), status=500)


URLS = {
    '/': index,
    '/healthz': healthz,
    '/switch-health': switch_health_status
}


class HTTPHandler(BaseHTTPRequestHandler):
    # Use HTTP 1.1 as 1.0 doesn't support chunked encoding
    protocol_version = "HTTP/1.1"

    response: HTTPResponse

    def do_HEAD(self):
        self.send_response(self.response.status)
        self.send_header('Content-type', self.response.content_type)
        self.send_header('Content-length', len(self.response.content.encode('utf-8')))
        self.end_headers()

    def do_GET(self):
        try:
            self.response = URLS.get(self.path, _404)()
        except Exception as e:
            self.response = _500(str(e))

        self.send_response(self.response.status)
        self.send_header('Content-type', self.response.content_type)
        self.send_header('Content-length', len(self.response.content.encode('utf-8')))
        self.end_headers()

        self.wfile.write(bytes(self.response.content, 'utf-8'))


if __name__ == '__main__':
    server_class = HTTPServer
    httpd = server_class((SETTINGS.HOST, SETTINGS.PORT), HTTPHandler)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
