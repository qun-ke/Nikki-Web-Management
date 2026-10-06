package org.example.controller;

import lombok.extern.slf4j.Slf4j;
import org.example.anno.LogOperation;
import org.example.pojo.Clazz;
import org.example.pojo.ClazzQueryParam;
import org.example.pojo.PageResult;
import org.example.pojo.Result;
import org.example.service.ClazzService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/clazzs")
public class ClazzController {
    @Autowired
    private ClazzService clazzService;

    //条件分页查询
    @GetMapping
    public Result page(ClazzQueryParam clazzQueryParam) {
        log.info("班级分页查询：{}", clazzQueryParam);
        PageResult<Clazz> pageResult = clazzService.page(clazzQueryParam);
        return Result.success(pageResult);
    }

    //根据ID删除班级
    @LogOperation
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        log.info("根据ID删除班级：{}", id);
        clazzService.deleteById(id);
        return Result.success();
    }

    //新增班级
    @LogOperation
    @PostMapping
    public Result add(@RequestBody Clazz clazz) {
        log.info("新增班级：{}", clazz);
        clazzService.add(clazz);
        return Result.success();
    }

    //根据ID查询班级
    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id) {
        log.info("根据ID查询班级：{}", id);
        Clazz clazz = clazzService.getById(id);
        return Result.success(clazz);
    }

    //修改班级
    @LogOperation
    @PutMapping
    public Result update(@RequestBody Clazz clazz) {
        log.info("修改班级：{}", clazz);
        clazzService.update(clazz);
        return Result.success();
    }

    //查询所有班级
    @GetMapping("/list")
    public Result list() {
        log.info("查询所有班级");
        List<Clazz> clazzList = clazzService.findAll();
        return Result.success(clazzList);
    }
}
