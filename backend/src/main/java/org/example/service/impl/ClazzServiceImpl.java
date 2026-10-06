package org.example.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.example.mapper.ClazzMapper;
import org.example.pojo.Clazz;
import org.example.pojo.ClazzQueryParam;
import org.example.pojo.PageResult;
import org.example.service.ClazzService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class ClazzServiceImpl implements ClazzService {
    @Autowired
    private ClazzMapper clazzMapper;

    //条件分页查询
    @Override
    public PageResult<Clazz> page(ClazzQueryParam clazzQueryParam) {
        //设置分页参数
        PageHelper.startPage(clazzQueryParam.getPage(), clazzQueryParam.getPageSize());
        List<Clazz> clazzList = clazzMapper.list(clazzQueryParam);
        Page<Clazz> p = (Page<Clazz>) clazzList;
        //计算每个班级的状态
        p.getResult().forEach(this::fillStatus);
        return new PageResult<>(p.getTotal(), p.getResult());
    }

    //根据ID删除班级
    @Override
    public void deleteById(Integer id) {
        clazzMapper.deleteById(id);
    }

    //新增班级
    @Override
    public void add(Clazz clazz) {
        clazz.setCreateTime(LocalDateTime.now());
        clazz.setUpdateTime(LocalDateTime.now());
        clazzMapper.add(clazz);
    }

    //根据ID查询班级
    @Override
    public Clazz getById(Integer id) {
        return clazzMapper.getById(id);
    }

    //修改班级
    @Override
    public void update(Clazz clazz) {
        clazz.setUpdateTime(LocalDateTime.now());
        clazzMapper.update(clazz);
    }

    //查询所有班级
    @Override
    public List<Clazz> findAll() {
        return clazzMapper.findAll();
    }

    //根据开课时间、结课时间计算班级状态：未开班 / 已开班 / 已结课
    private void fillStatus(Clazz clazz) {
        LocalDate now = LocalDate.now();
        if (now.isBefore(clazz.getBeginDate())) {
            clazz.setStatus("未开班");
        } else if (now.isAfter(clazz.getEndDate())) {
            clazz.setStatus("已结课");
        } else {
            clazz.setStatus("已开班");
        }
    }
}
