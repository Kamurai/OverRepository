/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Main;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

@ManagedBean(name="MainBean")
@RequestScoped
public class Bean
{
    private int level;
    public int getLevel()
    {
        return level;
    }    
    public void setLevel(int lvl)
    {
        level = lvl;
    }
    private int page;
    public int getPage()
    {
        return page;
    }
    public void setPage(int pg)
    {
        page = pg;
    }
    private int returnPage;
    public int getReturnPage()
    {
        return returnPage;
    }
    public void setReturnPage(int rt)
    {
        returnPage = rt;
    }
    
    private int extension; //pivot
    private Custom    cust;
    private Universal uni;

    public Bean()
    {
        //level = 0;
        //page = 0;
        //returnPage;
        extension = 4;

        cust = new Custom();
        uni = new Universal();
    }

    public String GetPath()
    {
        String temp = uni.GetPath(level);
        return temp;
    }

    public String GetStylePath()
    {
        return uni.GetPath(level-1);
    }

    public String Content()
    {
        return cust.Content(getPage());
    }

    public String Page()
    {
        return cust.Page(getReturnPage());
    }

    public String WebMaster()
    {
        return uni.WebMaster();
    }

    public String setLayout(int lvl, int pg, int rt)
    {
        setLevel(lvl);
        setPage(pg);
        setReturnPage(rt);

        return GetPath()+"Layout.xhtml";
    }
}
