package org.example.service;

import org.example.pojo.PageResult;
import org.example.pojo.Student;
import org.example.pojo.StudentQueryParam;

import java.util.List;

public interface StudentService {
    //条件分页查询
    PageResult<Student> page(StudentQueryParam studentQueryParam);

    //批量删除学员
    void delete(List<Integer> ids);

    //新增学员
    void add(Student student);

    //根据ID查询学员
    Student getById(Integer id);

    //修改学员
    void update(Student student);

    //违纪处理
    void updateViolation(Integer id, Integer score);
}
