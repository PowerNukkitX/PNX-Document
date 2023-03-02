# 延迟返回API  

## 查询API结果  

根据延迟返回API的请求UUID查询此API的处理结果，如果尚未处理完成，将会返回`204 No Content`，
如果已处理完成，将会返回`200 OK`，并在响应体中返回处理结果。  

url:

- /delayed/{uuid}

参数:

- uuid: 延迟返回API的请求UUID

