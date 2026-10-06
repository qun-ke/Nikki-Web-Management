import request from "@/utils/request"

//操作日志分页查询
export const logPageApi = (page, pageSize) =>
    request.get(`/log/page?page=${page}&pageSize=${pageSize}`)
