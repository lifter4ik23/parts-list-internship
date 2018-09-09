package net.alexmez.partslist.dao;

import net.alexmez.partslist.model.Part;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class PartDaoImpl implements PartDao {
    private final static Logger logger = LoggerFactory.getLogger(PartDao.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addPart(Part part) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(part);
        logger.info("Part successfully saved. Part details: " + part);
    }

    @Override
    public void updatePart(Part part) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(part);
        logger.info("Part successfully update. Part details: " + part);
    }

    @Override
    public void removePart(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        Part part = session.load(Part.class, id);

        if (part != null) {
            session.delete(part);
        }
        logger.info("Part successfully deleted. Part details: " + part);
    }

    @Override
    public Part getPartById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        Part part = session.load(Part.class, id);
        logger.info("Part successfully loaded. Part details: " + part);
        return part;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Part> listParts(String param) {
        String query;

        if (param == null || param.equals("all")) {
            query = "FROM Part";
        } else if (param.equals("needOnly")) {
            query = "FROM Part E WHERE E.necessity = true";
        } else if (param.equals("optionOnly")) {
            query = "FROM Part E WHERE E.necessity = false";
        } else {
            query = "FROM Part E WHERE E.partName like '%"+ param +"%'";
        }

        Session session = this.sessionFactory.getCurrentSession();
        List<Part> partList = session.createQuery(query).list();

        for (Part part : partList) {
            logger.info("Part list: " + part);
        }

        return partList;
    }
}
