#include <stdio.h>
#include <stdint.h>
#include <string.h>

/**
 * README
 *
 * This is a VERY basic test suite for the bank program.
 * I am providing this for the first assignment to help you get started with testing.
 *
 * The idea is that as you finish each function, the tests will start passing.
 *
 * PLEASE ADD MORE TESTS!
 * These tests are not exhaustive, and you should add more tests to make sure your code is correct.
 * It is also possible the tests are flawed since I wrote them quickly.
 * I did not write unit tests to test my unit tests.
 */

extern void greeting(void);
extern uint32_t get_pin(void);
extern void create_account(char *account_number, char *obscured_pin, char *balance);
extern void obscure_pin(char *str);
extern uint32_t calculate_balance(uint32_t account_number, uint32_t pin);
extern uint32_t calculate_account(uint32_t pin);

typedef struct
{
    void (*function)(void); // Function to run
    const char *name;       // Test name
} TestCase;

void test_greeting(void)
{
    greeting();
}

void test_get_pin(void)
{
    uint32_t pin = get_pin();
    if (pin != 1234)
    {
        printf("Test failed. Expected 1234, got %d.\n", pin);
    }
    else
    {
        printf("Test passed.\n");
    }
}

void test_calculate_account(void)
{
    uint32_t pin = 1234;
    uint32_t expected_account = 10000 + pin;
    uint32_t actual_account = calculate_account(pin);
    printf("Expected account: %d\n", expected_account);
    printf("Actual account: %d\n", actual_account);

    if (expected_account != actual_account)
    {
        printf("Test failed. Expected %d, got %d.\n", expected_account, actual_account);
    }
    else
    {
        printf("Test passed.\n");
    }
}

void test_create_account(void)
{
    char account_number[7] = {0}; // array to hold the account number as a string
    char obscured_pin[6] = {0};   // array to hold the obscured pin as a string
    char balance[7] = {0};        // array to hold the balance as a string

    create_account(account_number, obscured_pin, balance); // call the assembly function

    // check that the account number is correct
    if (strcmp(account_number, "11234") != 0)
    {
        printf("Test failed. Expected \"11234\", got \"%s\".\n", account_number);
    }
    else
    {
        printf("Test passed.\n");
    }
}

void test_calculate_balance(void)
{
    uint32_t account_number = 11234;
    uint32_t pin = 1234;
    uint32_t expected_balance = ((account_number + pin) * pin) & (pin ^ account_number);
    expected_balance = (expected_balance % 50000) + 50000;

    uint32_t actual_balance = calculate_balance(account_number, pin);
    printf("Expected balance: %d\n", expected_balance);
    printf("Actual balance: %d\n", actual_balance);

    if (expected_balance != actual_balance)
    {
        printf("Test failed. Expected %d, got %d.\n", expected_balance, actual_balance);
    }
    else
    {
        printf("Test passed.\n");
    }
}

void test_obscure_pin(void)
{
    char str1[6] = {'1', '2', '3', '4', '\0'};
    char str2[6] = {';', '<', '=', '>', '\0'};
    obscure_pin(str1);
    if (strcmp(str1, str2) != 0)
    {
        printf("Test failed. Expected \"%s\", got \"%s\".\n", str2, str1);
    }
    else
    {
        printf("Test passed.\n");
    }
}

// List of test cases
TestCase test_cases[] = {
    {test_greeting, "greeting"},
    {test_get_pin, "get_pin"},
    {test_calculate_account, "calculate_account"},
    {test_calculate_balance, "calculate_balance"},
    {test_obscure_pin, "obscure_pin"},
    {test_create_account, "create_account"},
};

int main(void)
{
    size_t num_tests = sizeof(test_cases) / sizeof(TestCase);
    for (size_t i = 0; i < num_tests; i++)
    {
        printf("Running test %s...\n", test_cases[i].name);
        test_cases[i].function();
    }
    return 0;
}
