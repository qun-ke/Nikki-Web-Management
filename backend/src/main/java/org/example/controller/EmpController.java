package org.example.controller;

import lombok.extern.slf4j.Slf4j;
import org.example.pojo.Emp;
import org.example.pojo.EmpQueryParam;
import org.example.pojo.PageResult;
import org.example.pojo.Result;
import org.example.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/emps")
public class EmpController {
    @Autowired
    private EmpService empService;
    //分页条件查询
    @GetMapping
    public Result page(EmpQueryParam empQueryParam){
        log.info("分页查询：{}",empQueryParam);
        PageResult<Emp> pageResult=empService.page(empQueryParam);
        return Result.success(pageResult);
    }
    //新增员工
    @PostMapping
    public Result add(@RequestBody Emp emp){
        log.info("新增员工："+emp);
        empService.add(emp);
        return Result.success();
    }

    //批量删除员工
    @DeleteMapping
    public Result delete(@RequestParam List<Integer> ids){
        log.info("批量删除员工：{}",ids);
        empService.delete(ids);
        return Result.success();
    }

    //根据ID查询员工信息
    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id){
        log.info("根据{}查询到员工",id);
       Emp emp= empService.getById(id);
       return  Result.success(emp);
    }

    //修改员工信息
    @PutMapping
    public Result update(@RequestBody Emp emp){
        log.info("修改员工：{}",emp);
        empService.update(emp);
        return Result.success();
    }

    //查询所有员工（班级表单班主任下拉框使用）
    @GetMapping("/list")
    public Result list(){
        log.info("查询所有员工");
        List<Emp> empList=empService.findAll();
        return Result.success(empList);
    }
}
