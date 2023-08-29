import java.util.Scanner;

public class Library {

    private String[] list;

    private  int count;

    public Library(int size) {
        if (size <= 0) throw new IllegalArgumentException("음수는 불가능");
        list = new String[size];
        for (int i = 0; i < list.length; i++) {
            list[i]="";

        }
        count =0;

    }

    public void add(String s) {

        if(count == list.length)
            throw new IllegalArgumentException("책장이 꽉 찼습니다");

        for (int i = 0; i < list.length; i++) {
            if(list[i].equals(s))
                throw new IllegalArgumentException("["+s+"]은 이미 있는책");

        }

        list[count]=s;
        count+=1;

    }

    public void delete(String s) {
        if (count == 0)
            throw new IllegalArgumentException("책장이 비어있어서 삭제 불가능");
        for (int i = 0; i < list.length; i++) {
            if (list[i].equals(s)) {
                for (int j = i; j < list.length - 1; j++) {
                    list[j] = list[j + 1];

                }
                list[list.length - 1] = "";
                count -= 1;
                return;

            }
        }
    }





    public void find(String s) {
        for (int i = 0; i < list.length; i++) {
            if (list[i].equals(s)) {
                System.out.println(s + "있는책입니다.");
                return;
            }
        }

        System.out.println(s+"없는책입니다.");


        }


    public void findAll() {
        System.out.println("\n모든 책 출력");
        System.out.println("============");

        for (int i = 0; i < list.length; i++) {
            if(list[i].equals(""))
                continue;
            System.out.println((i+1)+" "+list[i]);

        }

    }
}
