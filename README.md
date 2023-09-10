# Computer Organisation and Architecture - COS284 2023

---

Welcome to the **Computer Organisation and Architecture** repository! This repository contains a collection of NASM Assembly code examples and projects related to computer organization and architecture.

---

# `Getting Started`
- If you're new to `assembly language` or `NASM`, here are some resources to help you get started:
    - [NASM Documentation](https://www.nasm.us/doc/): Official documentation for NASM (Netwide Assembler).
    - [x86 Assembly Language Reference Manual](https://www.felixcloutier.com/x86/): A comprehensive reference guide for x86 assembly instructions.
---

# `Code Examples`
- This repository includes a variety of code examples that cover different aspects of computer organization and architecture. You'll find examples related to:
    - `Basic Assembly Concepts:` Start with simple examples to understand assembly language basics.
    - `Memory Manipulation:` Explore code for memory allocation, data storage, and retrieval.
    - `Arithmetic and Logic Operations:` Learn how to perform arithmetic and logic operations in assembly.
    - `Control Flow:` Study branching, loops, and conditional statements.
    - `Function Calls:` Understand how functions are called and managed in assembly.
- Feel free to browse the code examples in the respective directories to gain insights into the world of assembly language programming.

---

# `Featured Code Implementations`:
- #### 1. Quest Brief: Decrypt the Ancient Scroll
    - For this quest, you are tasked with mastering the ancient Vigenere cipher. This will allow you to send encrypted messages to allies and decipher the secrets of old. To guide you, consult the tome of knowledge: [Visit-Link](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher). Remember, in this cipher, spaces vanish like mist, so "HELLO WORLD" becomes "HELLOWORLD" before you cast your encryption spell. Assume your incantations will always be in uppercase runes without any mystical symbols.
    - ##### `Challenge 1 - Conjure the Matrix:`
        - For this challenge, you must craft an assembly spell named char** populateMatrix() that will conjure a 26x26 matrix of runes.
        - Each row of this matrix will have the alphabet shifted left based on the row’s mystical index (i.e., row 0 remains unchanged, row 1 shifts left by 1, row 2 shifts left by 2, and so on).
        - The spell must return a pointer to this matrix.  Your matrix would look something like if implemented correctly:
    - ##### `Challenge 2 - Rune Transformation:`
        - For this challenge, you must craft an assembly spell named char encryptChar(char**,char, char).
        - This spell will take a char**(the matrix from challenge 1) and two chars, transforming  the  first char using  the  matrix  and  the  key  rune  provided  as  the  second char as described in the cipher’s ancient scrolls.
        - The spell must return the transformed rune.
            - Example:  (This is not a prophecy, merely an example)
                - Given the rune: A
                - Given the key rune: L
                - The spell should produce: L
            - The Operation happening should look something like this:
                - B - Z -> A
                - Z - Z -> Y
                - A - L -> L
                - O - P -> D
    - ##### `Challenge 3 - Encrypt the Message:`
        - For this challenge, you must craft an assembly spell named char* encryptString(char**,char*, char*).
        - This spell will take the matrix from populateMatrix(), and two strings of runes (the message and the keyword).
        - Using the corresponding runes from both strings, it will repeatedly invoke the spell from challenge 2 to encrypt the entire message.
        - The spell must then return the fully encrypted message.
            - Example:
                - Given the message: ATTACK AT DAWN
                - Using the keyword: LEMON
                - The spell should produce: LXFOPVEFRNHR
- #### 2. Simple Library filled with Books
    - In this task you implement a simple library filled with books. The books and library will be defined by structs, and allocated dynamically.
    - ##### `Books:`
        - You need to implement a book struct, which contains the following fields:
            ```C
            struct Book {
                char isbn [13];
                char title [50];
                float price;
                int quantity;
            };
            ```
        - You will need to write an assembly function that receives the necessary parameters to create a book struct, and returns a pointer to the newly created and populated struct.
        - The function signature is as follows:
        ```C
        struct Book* allocateBook(char * isbn, char * title, float price, int quantity);
        ```
        - The struct and the function must be implemented in a single file called book.asm.
    - ##### `Library:`
        - You need to implement a library struct, which contains the following fields:
            ```C
            struct  Library {
                struct  Book  books [5];
                int  count;
            };
            ```
        - You will need to write a function that initialises an empty library with 0 books.
            ```C
                struct  Library* initialise Library(void);
            ```
        - The pointer returned from this function should have count set to 0, and the books array should  be  empty. To add a book to the library, you need to implement the following function:
            ```C
            int addBook(struct Library *lib , struct Book *book);
            ```
        - This function should add the book to the library, and return 1 if the book was added successfully, and 0 if the book could not be added. The library should not be able to contain more than 5 books. The function should also not add a book if the ISBN already exists in the library, it should instead add the quantity of the book with the same ISBN. The library can only hold 5 unique books, however it can hold multiple copies of the same book.
            - A deep copy must be made of the book
        - To search for a book in the library, you need to implement the following function:
            ```C
            struct Book* searchBookByISBN(struct Library *lib , char *isbn);
            ```
        - This function should return a pointer to the book if it is found, and a null pointer if the book is not found.

---
---

# `Requirements before running codes`:
- Install an `IDE` that `compiles` and `runs` Java codes. Recommendation `VS Code`
- How to setup `WSL` Ubuntu terminal shell and run it from `Visual Studio Code`: [Visit-Link](https://www.youtube.com/watch?v=fp45HpZuhS8&t=112s)
- Installing `NASM` / How to Run NASM Code in `Windows`: [Visit-Link](https://youtu.be/pL6u5Ieg86A?feature=shared)

---

# `Makefile`

##### NB: A makefile Is Included to compile and run the codes on the terminal with the following commands:=
- make clean
- make
- make run
- Makefile:
    ```assembly
        ASM_SOURCES := $(wildcard *.asm)
        C_TEST_SOURCES := $(wildcard *.c)
        OBJ_DIR := obj
        BIN_DIR := bin
        EXECUTABLE := $(BIN_DIR)/test
        ASM_OBJECTS := $(addprefix $(OBJ_DIR)/, $(notdir $(ASM_SOURCES:.asm=.o)))
        C_TEST_OBJECTS := $(addprefix $(OBJ_DIR)/, $(notdir $(C_TEST_SOURCES:.c=.o)))
        VPATH := src:src/helpers:test

        all: $(OBJ_DIR) $(BIN_DIR) $(EXECUTABLE)

        $(EXECUTABLE): $(ASM_OBJECTS) $(C_TEST_OBJECTS)
            gcc -no-pie -g -m64 -o $@ $^

        $(OBJ_DIR)/%.o: %.asm
            yasm -f elf64 -g dwarf2 $< -o $@

        $(OBJ_DIR)/%.o: %.c
            gcc -g -m64 -c $< -o $@

        $(OBJ_DIR):
            mkdir -p $(OBJ_DIR)

        $(BIN_DIR):
            mkdir -p $(BIN_DIR)

        run: $(EXECUTABLE)
            ./$(EXECUTABLE)

        debug: $(EXECUTABLE)
            gdb $(EXECUTABLE)

        clean:
            rm -f $(ASM_OBJECTS) $(C_TEST_OBJECTS) $(EXECUTABLE) *.tar.gz
            clear
            reset

        fresh: clean all

        tar:
            tar -cvz *.asm -f Code.tar.gz
    ```

---

---

<p align="center">The End, Thank You</p>

---
