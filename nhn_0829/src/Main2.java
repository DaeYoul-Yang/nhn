import java.util.Scanner;
//미완성
public class Main2 {
    public static void main(String[] args) {



    try{
        new Library(-1);
    }catch(IllegalArgumentException exception){
        System.out.println(exception.getMessage());
    }

    Library library =new Library(5);

    library.add("해리포터");
    library.add("샬롯의 거미줄");
    try

    {
        library.add("샬롯의 거미줄");
    }catch (IllegalArgumentException e){
        System.out.println(e.getMessage());
    }

    library.delete("해리포터");
    try

    {


        library.delete("스파이더맨");
    }catch(IllegalArgumentException e){
        System.out.println(e.getMessage());
    }
    library.find("샬롯의 거미줄");
    library.find("샬롯의 거미줄2");

    library.findAll();

    library.add("Java 7");
    library.add("Java 8");
    library.add("Java 9");
    library.add("Java 10");

    library.findAll();



    }
}
