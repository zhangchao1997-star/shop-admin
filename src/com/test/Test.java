package com.test;

public class Test {
    public static void main(String[] args) {
        String reg="[a-zA-Z0-9]{5,12}";
        String test_Str = "12341114894a";
        System.out.println(test_Str.matches(reg));
    }
}
