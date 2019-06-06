package Bean;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import java.util.List;
import java.util.ArrayList;

@ManagedBean(name="TestBean")
@RequestScoped
public class TestBean{
    public List<String> testList = new ArrayList<String>();
    public List<String> getTestList(){
        return testList;
    }
    public void setTestList(List<String> testList){
        this.testList = testList;
    }
    
    public TestBean(){
        testList.add("Zero");
        testList.add("One");
        testList.add("Two");
        testList.add("Three");
        testList.add("Four");
    }
}
