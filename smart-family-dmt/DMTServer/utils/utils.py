from typing import Dict, Any


def get_api_response(status_code: int, body: Any) -> Dict[str, Any]:
    return {
        "statusCode": status_code,
        "body": body
    }
