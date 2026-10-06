package org.example.controller;

import lombok.extern.slf4j.Slf4j;
import org.example.pojo.ClazzChart;
import org.example.pojo.JobChart;
import org.example.pojo.Result;
import org.example.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/report")
public class ReportController {
    @Autowired
    private ReportService reportService;
    //统计员工职位人数
    @GetMapping("/empJobData")
    public Result getEmpJobData(){
        log.info("统计员工职位人数");
        JobChart jobChart=reportService.getEmpJobData();
        return Result.success(jobChart);
    }


    //统计员工性别人数
    @GetMapping("/empGenderData")
    public Result getempGenderData(){
        log.info("统计员工性别人数");
        List<Map<String,Object>> genderList=reportService.getempGenderData();
        return Result.success(genderList);
    }

    //学员学历统计
    @GetMapping("/studentDegreeData")
    public Result getStudentDegreeData(){
        log.info("学员学历统计");
        List<Map<String,Object>> degreeList=reportService.getStudentDegreeData();
        return Result.success(degreeList);
    }

    //班级人数统计
    @GetMapping("/studentCountData")
    public Result getStudentCountData(){
        log.info("班级人数统计");
        ClazzChart clazzChart=reportService.getStudentCountData();
        return Result.success(clazzChart);
    }
}
