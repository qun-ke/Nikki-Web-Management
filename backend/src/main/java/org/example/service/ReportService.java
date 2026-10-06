package org.example.service;

import org.example.pojo.ClazzChart;
import org.example.pojo.JobChart;


import java.util.List;
import java.util.Map;

public interface ReportService {

    //统计员工职位人数
    JobChart getEmpJobData();

    //统计员工性别人数
    List<Map<String, Object>> getempGenderData();

    //学员学历统计
    List<Map<String, Object>> getStudentDegreeData();

    //班级人数统计
    ClazzChart getStudentCountData();
}
