package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.EducationalResources;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
@Slf4j
public class AdminResourceDao {
    private final SqlSession session;


    public int educationUpload(EducationalResources educationalResources) {
        return session.insert("educationUpload", educationalResources);
    }

    public List<EducationalResources> listEdu() {
        List<EducationalResources> listEdu = null;
        try {
            listEdu = session.selectList("listEdu");
            log.info(listEdu.toString());
        } catch (Exception e) {
            log.info(e.getMessage());
        }
        return listEdu;
    }
}
