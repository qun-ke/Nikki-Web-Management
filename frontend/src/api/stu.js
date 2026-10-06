import request from "@/utils/request"

//学员分页条件查询（name 姓名，degree 学历，clazzId 班级ID）
export const queryStuPageApi = (name, degree, clazzId, page, pageSize) =>
    request.get(`/students?name=${name}&degree=${degree}&clazzId=${clazzId}&page=${page}&pageSize=${pageSize}`)

//添加学员
export const addStuApi = (data) => request.post('/students', data)
//根据id查询学员
export const queryStuByIdApi = (id) => request.get(`/students/${id}`)
//修改学员
export const updateStuApi = (data) => request.put('/students', data)
//批量删除学员（ids 为id数组，如 [1,2,3]）
export const deleteStuApi = (ids) => request.delete(`/students/ids?ids=${ids}`)
//违纪处理（id 学员ID，score 扣除分数）
export const violationApi = (id, score) => request.put(`/students/violation/${id}/${score}`)
