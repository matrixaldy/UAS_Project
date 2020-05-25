/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.lang.String;
import java.lang.Integer;
import java.lang.Float;
import java.util.Hashtable;
import java.util.Enumeration;

/**
 *
 * @author matri
 */
public class ShoppingCart {
    protected Hashtable items=new Hashtable();
    public void addItem(String itemId, String desc, float price, int qty, String img) {
        String[] item = {itemId, desc, Float.toString(price), Integer.toString(qty), img};
        
        if(items.containsKey(itemId)) {
            String[] tmpItem = (String[])items.get(itemId);
            int tmpQty = Integer.parseInt(tmpItem[3]);
            qty += tmpQty;
            tmpItem[3] = Integer.toString(qty);
        } else {
            items.put(itemId, item);
        }
    }
    
    public void removeItem(String itemId) {
        if(items.containsKey(itemId)) {
            items.remove(itemId);
        }
    }
    
    public void updateQty(String itemId, int qty) {
        if(items.containsKey(itemId)) {
            String[] tmpItem = (String[])items.get(itemId);
            tmpItem[3] = Integer.toString(qty);
        }
    }
    
    public Enumeration getEnumeration() {
        return items.elements();
    }
    
    public float getCost() {
        Enumeration e = items.elements();
        String[] tmpItem;
        float totalCost= 0.00f;
        while(e.hasMoreElements()) {
            tmpItem = (String[])e.nextElement();
            totalCost += (Integer.parseInt(tmpItem[3])*Float.parseFloat(tmpItem[2]));
        }
        return totalCost;
    }
    
    public int getNumOfItems() {
        Enumeration e = items.elements();
        String[] tmpItem;
        int numOfItem = 0;
        while(e.hasMoreElements()) {
            tmpItem = (String[])e.nextElement();
            numOfItem += (Integer.parseInt(tmpItem[3]));
        }
        return numOfItem;
    }
}
