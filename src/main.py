"""HITBot MCP Server - Healthcare Information Technology Bot Operations Toolkit.

This module implements an MCP (Model Context Protocol) server that provides
integration with the HITL Snowflake data warehouse for candidate and job order search
capabilities using Snowflake's Cortex Search Service.
"""

import logging

from fastmcp import Context,FastMCP
from starlette.responses import JSONResponse

# Configure logging
logger = logging.getLogger(__name__)
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

# Create a named server with dependencies
mcp = FastMCP("Healthcare Information Technology Bot Operations Toolkit (HITBot)")

@mcp.custom_route("/health", methods=["GET"])
async def health_check(request):
    return JSONResponse({"status": "healthy", "message": "Sure, why not."})

@mcp.tool()
def server_info(ctx: Context) -> dict:
    """Get information about the current server."""
    return {
        "name": ctx.fastmcp.name,
        "instructions": ctx.fastmcp.instructions,
        "debug_mode": ctx.fastmcp.settings.debug,
        "log_level": ctx.fastmcp.settings.log_level,
        "host": ctx.fastmcp.settings.host,
        "port": ctx.fastmcp.settings.port,
    }

# Main section to run the server

asgi = mcp.http_app()

if __name__ == "__main__":

    # Run with Streamable HTTP transport which supports HTTP/TCP
    mcp.run(transport="http")
