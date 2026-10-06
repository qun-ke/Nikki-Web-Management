import request from "@/utils/request"

//员工列表查询
export const queryPageApi = (name, gender, begin, end, page, pageSize) =>
    request.get(`/emps?name=${name}&gender=${gender}&begin=${begin}&end=${end}&page=${page}&pageSize=${pageSize}`)

//添加员工
export const addEmpApi = (data) => request.post('/emps', data)
//根据id查询员工
export const queryEmpByIdApi = (id) => request.get(`/emps/${id}`)
//修改部门
export const updateEmpApi = (data) => request.put('/emps', data)
//删除部门
export const deleteEmpApi = (ids) => request.delete(`/emps?ids=${ids}`)
//查询所有员工（班级表单班主任下拉框使用）
export const queryAllEmpApi = () => request.get('/emps/list')