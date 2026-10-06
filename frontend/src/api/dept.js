import request from "@/utils/request"

//列表查询
export const queryAllApi = () => request.get('/depts')

//添加部门
export const addDeptApi = (data) => request.post('/depts', data)
//根据id查询部门
export const queryDeptByIdApi = (id) => request.get(`/depts/${id}`)
//修改部门
export const updateDeptApi = (data) => request.put('/depts', data)
//删除部门
export const deleteDeptApi = (id) => request.delete(`/depts?id=${id}`)