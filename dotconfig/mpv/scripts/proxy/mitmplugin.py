from mitmproxy import http
import re

ONE_MB_BLOCK = 1024 * 1024
http_chunk_size = {}
http_chunk_size[".googlevideo.com"] = ONE_MB_BLOCK * 10


def request(flow: http.HTTPFlow) -> None:
    if flow.request.headers.get("range"):
        # Range: bytes=0-
        range_data = re.split(r"(\d+)", flow.request.headers["range"])
        for key in http_chunk_size:
            if flow.request.headers.get("host").find(key) != -1:
                flow.request.headers["range"] = flow.request.headers["range"] + str(
                    int(range_data[1]) + http_chunk_size[key]
                )
                break

