exports.handler =  async function(event, context) {
    const response = {
    statusCode: 200,
    body: `
  ${'x'.repeat(128)}
    Hello from ${process.env.AWS_LAMBDA_FUNCTION_NAME} you are in (${process.env.AWS_DEFAULT_REGION}/${process.env.AWS_REGION}) you came from ${event.headers.origin}!    
  ${'x'.repeat(128)}
    `};
  
  return response;
};
