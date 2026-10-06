package org.example.service;

import com.github.pagehelper.PageHelper;
import org.example.mapper.EmpMapper;
import org.example.pojo.Emp;
import org.example.pojo.EmpQueryParam;
import org.example.pojo.LoginInfo;
import org.example.pojo.PageResult;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.List;

public interface EmpService {
    //分页查询
    //PageResult<Emp> page(Integer page, Integer pageSize,String name, Integer gender, LocalDate begin, LocalDate end);
    PageResult<Emp> page(EmpQueryParam empQueryParam);

    //新增员工
    void add(Emp emp);
    //批量删除员工
    void delete(List<Integer> ids);

    //根据ID查询员工信息
    Emp getById(Integer id);

    //修改员工信息
    void update(Emp emp);

    //用户登录
    LoginInfo login(Emp emp);

    //查询所有员工（班级表单班主任下拉框使用）
    List<Emp> findAll();
}
