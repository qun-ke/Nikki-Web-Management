package org.example.controller;

import lombok.extern.slf4j.Slf4j;
import org.example.anno.LogOperation;
import org.example.pojo.Dept;
import org.example.pojo.Result;
import org.example.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RequestMapping("/depts")
@RestController
public class DeptController {
    @Autowired
    private DeptService deptService;
//    @RequestMapping(value = "/depts",method = RequestMethod.GET)
    @GetMapping
    public Result list(){
        //System.out.println("查询部门全部数据");
        log.info("查询部门全部数据");
        List<Dept> deptList=deptService.findAll();
        return Result.success(deptList);
    }
    @LogOperation
    @DeleteMapping
    public Result delete(Integer id){
        //System.out.println("根据Id删除部门"+id);
        log.info("根据Id删除部门"+id);
        deptService.deleteById(id);
        return Result.success();
    }
    @LogOperation
    @PostMapping
    public Result add(@RequestBody Dept dept){
        //System.out.println("新增部门："+dept);
        log.info("新增部门："+dept);
        deptService.add(dept);
        return Result.success();
    }
    @GetMapping("/{id}")
    public Result getInfo(@PathVariable Integer id){
        //System.out.println("根据id查询部门："+id);
        log.info("根据id查询部门："+id);
        Dept dept=deptService.getById(id);
        return Result.success(dept);
    }

    @PutMapping
    public  Result update(@RequestBody Dept dept){
        //System.out.println("修改部门信息："+dept);
        log.info("修改部门信息："+dept);
        deptService.update(dept);
        return Result.success();
    }
}
