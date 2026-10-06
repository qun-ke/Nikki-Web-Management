package org.example.service.impl;

import org.example.mapper.ClazzMapper;
import org.example.mapper.EmpMapper;
import org.example.mapper.StudentMapper;
import org.example.pojo.ClazzChart;
import org.example.pojo.JobChart;
//import org.example.pojo.JobOption;
import org.example.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ReportServiceImpl implements ReportService {
    @Autowired
    private EmpMapper empMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private ClazzMapper clazzMapper;

    //统计员工职位人数
    @Override
    public JobChart getEmpJobData() {
        List<Map<String,Object>> empJobList=empMapper.countEmpJobData();
        List<Object> jobList=empJobList.stream().map(dataMap->dataMap.get("pos")).toList();
        List<Object> dataList=empJobList.stream().map(dataMap->dataMap.get("num")).toList();
        return new JobChart(jobList,dataList);
    }


    //统计员工性别人数
    @Override
    public List<Map<String, Object>> getempGenderData() {

        return empMapper.countGenderData();
    }

    //学员学历统计
    @Override
    public List<Map<String, Object>> getStudentDegreeData() {
        return studentMapper.countDegreeData();
    }

    //班级人数统计
    @Override
    public ClazzChart getStudentCountData() {
        List<Map<String,Object>> countList=clazzMapper.countStudentByClazz();
        List<Object> clazzList=countList.stream().map(dataMap->dataMap.get("name")).toList();
        List<Object> dataList=countList.stream().map(dataMap->dataMap.get("value")).toList();
        return new ClazzChart(clazzList,dataList);
    }
}
