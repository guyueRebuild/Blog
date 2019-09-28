package com.blog.test;

import java.io.InputStream;

public class Test {
    public static void main(String[] args) {
        String[] split = ",".split("ello,hee,hh");



        for (String s : split) {
            System.out.println(s);
        }
    }
}
