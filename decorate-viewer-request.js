async function handler(event) {
    console.log(event);
    const request = event.request;
    const headers = request.headers;
    const host = request.headers.host.value.toLowerCase();   

    // If origin header is missing, set it equal to the host header.
    if (!headers.origin)
        headers.origin = { value: `${host}` };

    return request;
}