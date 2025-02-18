import std/[asyncdispatch, httpclient]
import re

proc getEmails*(target: string) {.async.} =
  var client = newAsyncHttpClient()
  try:
    let response = await client.get(target)
    let html = await response.body
    let emailRegex = re(r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,7}\b")
    for email in findAll(html, emailRegex):
        echo email
  finally:
    client.close()