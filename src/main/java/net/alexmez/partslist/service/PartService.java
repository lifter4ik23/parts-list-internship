package net.alexmez.partslist.service;

import net.alexmez.partslist.model.Part;

import java.util.List;

public interface PartService {
    void addPart(Part part);

    void updatePart(Part part);

    void removePart(int id);

    Part getPartById(int id);

    List<Part> listParts(String param);
}
