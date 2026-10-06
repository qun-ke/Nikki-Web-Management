import request from "@/utils/request"

//员工性别统计
export const empGenderApi = () => request.get('/report/empGenderData')
//员工职位人数统计
export const empJobApi = () => request.get('/report/empJobData')
//学员学历统计
export const studentDegreeApi = () => request.get('/report/studentDegreeData')
//班级人数统计
export const studentCountApi = () => request.get('/report/studentCountData')
