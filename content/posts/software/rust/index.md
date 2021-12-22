---
title: "My Experience with Rust"
date: 2021-12-21
menu:
  sidebar:
    name: Rust Experiences
    identifier: rust
    parent: software
    weight: 10
tags: ["Multi-lingual"]

---

A while ago I stumbled across some mention of the [Stack Overflow Developer Survey](https://insights.stackoverflow.com/survey/2021#most-loved-dreaded-and-wanted-language-love-dread) which found that the Rust language has held the spot of most loved programming language since 2016. That seemed interesting to me but I didn't follow it up in any way.

A while later I came across some Rust tutorial videos on one of the YouTube channels I frequently visit and looked into it a bit. Looked pretty involved to me and that was that again.

Still a while later I decided to learn a new language. I can't recall what made me reach that decision, it somehow grew in my mind until the time came to act on it. I considered two choices: Julia and Rust. Both seemed like interesting challenges with Julia being the more obvious choice, it being more accessible and geared towards scientific computing. However, for some reason I really felt like learning Rust. I had read good things about it, how it was memory-safe and how it was considered a very promising technology to use for things like operating systems, browsers and this kind of crucial infrastructure.

I asked people on Reddit what they thought about the matter and I ended up with mixed respones. In essence, I was told what I already knew: Rust has a steeper learning curve than Julia with the latter being the more obvious choice, since I'm a scientist after all.

Consequently, I chose to learn Rust.

This was in March, so, as of today, roughly 10 months ago I started to write my first pieces of Rust example code. 

I began with reading [The Book](https://doc.rust-lang.org/book/) which is one of the recommended resources to start with and from the very beginning I was very glad that this wasn't my first language. Sure, Python is probably as far away from Rust as you can get (at least I sometimes feel that way although it's definitely not true) but at least I already knew the very basics of programming like variables, control flow, functions, loops, you know the drill.

One of the first things I realized is that Python hides from you how important types are. While learning Rust I slowly began to understand that there's much more to this than just "Well, there's numbers and there's strings and you can convert them into each other by typing this function and be done with it.". 

Dealing with types is *hard*. And since Rust is statically typed this means that every variable needs to be initialized with a specific type that may not be changed again. Also, there's all kinds of different integer numbers and more than one kind of floating point numbers as well as a metric fuckton of types for dealing with strings. That latter part is particularly true for Rust, it seems. Seriously, there's `String`, `str`, `&str`, `OsString`, `&[u8]`, `char` and surely more I am forgetting. Technically, not all of these are strings but they all relate to processing text. I had never thought about this before but human readable text is pretty messy what with different languages, alphabets with different character sets, encodings and whatnot. This can be pretty confusing if you're not used to this stuff.

Fortunately, Rust doesn't force you to expiclitly define a type for each variable you declare, it infers what type everything should be as much as possible. This works pretty well because often the type of a variable can be defined by how you use it in your code. Still, you frequently need to take care of this by hand as there are many instances where the compiler has no way to know what you want.

Another thing I found out about while reading the introductory text is memory management. That's a thing. There are things called "stack" and "heap" where data is stored which have different properties. In general, the language (just as others of its kind, I imagine) has you think about the allocation of memory, when and where that happens, ways to avoid it, when it's freed again and so on. I don't think I had ever worried (or even thought) about that before.

That's already enough for an unprepared mind to digest but Rust's truly unique feature is it's ownership model. Any piece of data can only be owned by one variable at a time. It can be passed around to other variables and the data can be borrowed by yet other variables. 

Consequently, the following won't compile because after passing ownership of the data held by `a` to `b` the variable `a` is uninitialized and the data it held in not accessible anymore.

```rust
let a = "Hello";
let b = a;
println!("{}", a);
```

At any given time there may be an arbitrary amount of immutable or exactly one mutable borrows active. That means you can process borrowed data without changing it as often as you like in the same scope but there can only be one active mutating reference to the data. This means something like the following won't work:

```rust
let mut a = "Hello";
let b = &a;
let c = &mut a;
println!("b: {}, c: {}", b, c);
```

The compiler will then produce this:

```
error[E0502]: cannot borrow `a` as mutable because it is also borrowed as immutable
  --> src/main.rs:72:13
   |
71 |     let b = &a;
   |             -- immutable borrow occurs here
72 |     let c = &mut a;
   |             ^^^^^^ mutable borrow occurs here
73 |     println!("b: {}, c: {}", b, c);
   |                              - immutable borrow later used here
```

which is a nice example of the compilers detailed error messages.

This prevents inconsistencies where, e.g., two different functions edit the same data. As it happens, this also works across different threads which is why multithreading in Rust is inherently safe.

This appears to be a novel feature in programming languages and while it may seem straightforward (and in principle it is), in practice it results in a lot of compiler errors telling you things like: "Sorry man, I can't let you do that!". Might have paraphrased a bit there.

This is known as "fighting the borrow-checker" and is pretty much constantly popping up when you're new to Rust. At least I hope so because that would mean that I wasn't the only one struggling with the concept.

In general the Rust compiler will be your constant companion once you start writing any code with it. That can be the source of a lot of frustration because it will frequently give you errors because of (mostly stupid) stuff you're trying to do, especially in the beginning but by now I have come to appreciate it. It produced incredibly detailed error messages, points out exactly where in your code something went wrong and often suggests possible fixes (which oftentimes will be the ones you actually want). It's not perfect, sometimes you get errors telling you that the type of the variable you're using doesn't satisfy a trait bound or other (whatever that means) which is techinically true of course but the real issue is rather that you mistyped or forget an ampersand or something of the sort. I'm not going to blame anyone for this though, a compiler can only be so smart.

During my time reading the Book I realized that, apart from the compiler itself, Rust has quite a few convenient features that make development very streamlined. It comes with a built-in utility tool called `cargo` that can start new projects, handle dependency resolving fo them and can build, run and test your code (if you wrote any tests that is). It also has an automatic code formatter and linter all out of the box! I think this is pretty neat because it eliminates the need for third-party tools to achieve all these things. Devs don't have to figure out how to do unit or integration testing, write build scripts, download dependencies for their projects manually, spend time formatting code according to style guides or hunt down obvious problems with third-party linters. All of that (and much more) is handled by `cargo` and can be integrated into an IDE which adds a whole lot of convenience to the whole experience. I kinda wish Python had this...

`cargo` also locks all the dependencies you used during compilation to a specific version and saves this in a file. If you distribute this file alongside your code and have people use it, they are guaranteed to get the exact same binary on their machine that you did. All versions of all dependencies are guaranteed to stay available in Rust's central repository on [crates.io](https://crates.io/) so you won't run into the problem of outdated library versions that are not available anymore. 

With Python, it happened several times that some package wouldn't run because I dind't have the proper Python version, dependencies and the right versions for those. I know it's possible to take care of this kind of problem during distribution of your code, thing is... many people don't. And you, as the end user, have to deal with the mess. Rust does all of this automatically so you can't just *not* take care of it (unless you actively try).

In general, I feel like Rust tries to help me along quite a bit but I still frequently feel like my head is ready to burst while trying to have it wrap around all the core concepts of the language. This is to be expected if all you know is Python, still, learning all about structs, enums, traits, pointers, closures, iterators and so on hasn't been easy. All these things are thrown in my face but I (almost) always felt like it was worth learning them because they make me a better Rustacean and also a better programmer in general. Why is that?

Well, take error handling for example: whenever a Rust function can fail because of any reason it returns a specific `Result` type. This is an enum that contains either an `Ok` variant containing any data the function is supposed to return or an `Err` variant which holds information about what went wrong (broadly speaking). Rust will make you handle the possibility of an `Err` variant, if present, and it's encoded in the language's type system. This also means that any IDE you're using will tell you to handle the `Result` type that was returned from this function or that, otherwise it'll throw a compiler error to remind you nicely. Maybe this concept is nothing new to the programming world but to me it felt revolutionary. It makes you write code that acknowledges things can go wrong and handle that appropriately which makes for more correct code. I also feel like I think a lot more about things that can possibly go wrong and how to deal with it. Sure, that may result in longer development time but in the end you don't end up with a program that does run but throws an error every time it encounters an (maybe not-so-)edge case that you hadn't considered previously.

Similarly, when a function can return either something or nothing, Rust wraps this in an `Option` enum. This is another way of Rust making you deal with the possibility that "nothing" can happen when you call a function and makes you deal with it, all at the level of the typing system. I've come to really appreciate this and found myself getting frustrated at the fact that Python doesn't have the perks of a statically typed language.

The next things I found difficult to get right were iterators and closures. I know Python has these too but they're much less prominent (or maybe that's just my inexperience speaking). I like how iterator adapters can make long chains of operations on iterators succinct and readable (especially if you have an IDE with inline type annotations). Here is an example for my code:

```rust
let region_atoms: Vec<usize> = pdb
    .atoms()
    .filter(|a| match region.unwrap() {
        Region::QM1 => a.occupancy() == 1.00,
        Region::QM2 => a.occupancy() == 2.00,
        Region::Active => a.b_factor() == 1.00,
    })
    .map(|a| a.serial_number())
    .collect();
```

It creates an iterator from a struct containing many elements, filters some of them out, maps the remaining elements to a function and collects the result to a `Vec`. This is just so cool, I love it!

However, I sometimes struggled (and still occasionally do) with the use of closures for them. I had particular trouble with returning `Result`s from within closures used in iterators and spent quite a bit of time trying to figure that out and asking people in the official forum. Unfortunately there's no one way to deal with it, but then again there couldn't be since the use cases are quite varied. The end result can look something like this:

```rust
 file.lines()
     .enumerate()
     .map(|(i, l)| -> Result<String, anyhow::Error> {
         Ok(l.context(format!(
             "{}: {}",
             "COULDN'T READ LINE FROM FILE".red(),
             i.to_string().blue()
         ))?
         .trim()
         .to_owned();
      })
      .collect::<Result<Vec<String>, anyhow::Error>>()?
      .join(",")
```

I think this is a bit scary but this is what can come out if you want to apply a `map` to an with a closure that can fail. In this case, something might go wrong during reading the file I'm interested in. On a side note: imagine having to format this kind of thing by hand. Ugh.

I probably still haven't used the full potential of what closures can do. I recently bound one to a variable for the first time to precompute a boolean which I later used in a `filter` operation on an iterator. Boy, did I feel clever after I had thought of that. Sure, that kind of thing is already in the Book but still! In the same line of thought I managed to use a struct holding a closure to cache an expensive function in order to postpone its execution to the very last moment and have it happen only once. Also an example from the Book and I had to look for help online still but it does feel good to remember concepts I read about and successfully implement them into my code:

```rust
struct PDBCacher<T>
where
    T: Fn() -> Result<pdbtbx::PDB, anyhow::Error>,
{
    calculation: T,
    value: Option<Result<pdbtbx::PDB, anyhow::Error>>,
}

impl<T> PDBCacher<T>
where
    T: Fn() -> Result<pdbtbx::PDB, anyhow::Error>,
{
    fn new(calculation: T) -> PDBCacher<T> {
        PDBCacher {
            calculation,
            value: None,
        }
    }

    fn get_pdb(&mut self) -> &mut Result<pdbtbx::PDB, anyhow::Error> {
        if self.value.is_none() {
            self.value = Some((self.calculation)());
        }
        self.value.as_mut().unwrap()
    }
}
```

This kind of thing still frequently boggles my mind but it's worth learning (not to mention a crucial aspect of the language itself). What's more, the difference in performance was instantly felt! Yay!

Just recently I defined my first custom trait and implemented it for two types. I then discovered that trait objects can only be used in function signatures and almost scrapped my work because I thought it had been useless. But then I remembered/learned that trait objects can be wrapped in a pointer (usually a `Box`) to circumvent this issue. I used this to implement an undo/redo functionality in my program. It tracks edit actions triggered by the user, stores them in a `Vec` and applies the opposite of them when an `undo` command is issued by the user. Since several different edit actions are possible I defined a `Revertable` trait and implemented it on the relevant types to enable a `Vec` to store `Box`ed instances of them. After I had pulled that off I felt like a freaking genius. At some point I learned that this kind of pattern is called the "command paradigm" (I think). Huh. What do you know?

I could still go on a while but I think I've made a few points. The bottom line (so far) is this: me learning Rust is very much a work in progress. So far I've only been working on one non-trivial work-related project. I've been extending and refactoring it for months now but I still enjoy working on it. For one, it's actually useful to me but what's just as important is that I can learn a lot about Rust in the process. I consider this a win. 

Something that I like about this learning experience is that I would venture to say that it has made me a better programmer. Rust encourages me to think about what I'm doing (okay, that's not specific to Rust, I know that) and do it right. It makes me think about correctness, makes me handle possible error sources and tells me when I'm trying to do stupid stuff which still happens but much less frequent now. Sure, the fact that I can get it to compile doesn't mean that it's gonna return the correct results since there are still plenty of semantic errors to make but what are tests for? Writing these is easy to do and very much a good idea. I am much more confident in the resulting Rust program than I ever was in the Python version of it which still lives in some dusty corner on my machine. I haven't looked at it in a long time and by now I'm scared to do so...

Last but not least: Rust is pretty fast. If your code is reasonably idiomatic and you think about what you want to do properly, you can come up with really performant code. I won't pretend I'm in any way a great Rust programmer but after careful thinking and using the appropriate data structures I was able to remove a couple bottlenecks in my code and the result could be felt immediately. I have never thought about this while writing Python (not much point in it I suppose) but I realized that I enjoy writing code that runs extremely fast. It's also gratifying that you can boost performance by careful thinking, structuring and using the appropriate tools for the job and not being limited by the language itself.

So yeah. I like Rust. It gave me a hard time, still does at times but I feel like it's worth it. I learned a lot, not only Rust-specific things, became a better programmer (in case I hadn't already mentioned) and mostly enjoyed the ride. I think I'm going to continue with it, there's still much to learn and understand...