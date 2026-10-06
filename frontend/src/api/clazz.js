import request from "@/utils/request"

//班级分页条件查询（name 班级名称，begin/end 结课时间范围）
export const queryClazzPageApi = (name, begin, end, page, pageSize) =>
    request.get(`/clazzs?name=${name}&begin=${begin}&end=${end}&page=${page}&pageSize=${pageSize}`)

//添加班级
export const addClazzApi = (data) => request.post('/clazzs', data)
//根据id查询班级
export const queryClazzByIdApi = (id) => request.get(`/clazzs/${id}`)
//修改班级
export const updateClazzApi = (data) => request.put('/clazzs', data)
//删除班级
export const deleteClazzApi = (id) => request.delete(`/clazzs/${id}`)
//查询所有班级（学员表单班级下拉框使用）
export const queryAllClazzApi = () => request.get('/clazzs/list')
