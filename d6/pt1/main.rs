use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::VecDeque;

pub fn main() {
    let file = BufReader::new(File::open("./input.txt").expect("Unable to open file"));
    let mut v = VecDeque::new();
    let mut i = 0;
    for line in file.lines() {
        for ch in line.expect("Unable to read line").chars() {
            v.push_back(ch);
            i+=1;
            if v.len() == 4 {
                let mut cv = Vec::from(v.clone());
                cv.sort_unstable();
                cv.dedup();
                if cv.len() == 4 {
                    println!("{0}", i);
                    return
                }
                v.pop_front();
            }
        }
    }
}
