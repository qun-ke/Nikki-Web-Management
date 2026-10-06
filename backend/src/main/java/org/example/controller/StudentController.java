package org.example.controller;

import lombok.extern.slf4j.Slf4j;
import org.example.anno.LogOperation;
import org.example.pojo.PageResult;
import org.example.pojo.Result;
import org.example.pojo.Student;
import org.example.pojo.StudentQueryParam;
import org.example.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/students")
public class StudentController {
    @Autowired
    private StudentService studentService;

    //条件分页查询
    @GetMapping
    public Result page(StudentQueryParam studentQueryParam) {
        log.info("学员分页查询：{}", studentQueryParam);
        PageResult<Student> pageResult = studentService.page(studentQueryParam);
        return Result.success(pageResult);
    }

    //批量删除学员
    @LogOperation
    @DeleteMapping("/{ids}")
    public Result delete(@PathVariable List<Integer> ids) {
        log.info("批量删除学员：{}", ids);
        studentService.delete(ids);
        return Result.success();
    }

    //新增学员
    @LogOperation
    @PostMapping
    public Result add(@RequestBody Student student) {
        log.info("新增学员：{}", student);
        studentService.add(student);
        return Result.success();
    }

    //根据ID查询学员
    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id) {
        log.info("根据ID查询学员：{}", id);
        Student student = studentService.getById(id);
        return Result.success(student);
    }

    //修改学员
    @LogOperation
    @PutMapping
    public Result update(@RequestBody Student student) {
        log.info("修改学员：{}", student);
        studentService.update(student);
        return Result.success();
    }

    //违纪处理
    @LogOperation
    @PutMapping("/violation/{id}/{score}")
    public Result updateViolation(@PathVariable Integer id, @PathVariable Integer score) {
        log.info("违纪处理，学员ID：{}，扣除分数：{}", id, score);
        studentService.updateViolation(id, score);
        return Result.success();
    }
}
