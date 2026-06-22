CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2 -g

TARGET = orderbook
OBJS = Order.o Trade.o OrderBook.o main.o

TEST_TARGET = tests
TEST_OBJS = Order.o Trade.o OrderBook.o tests/OrderBookTest.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS)

$(TEST_TARGET): $(TEST_OBJS)
	$(CXX) $(CXXFLAGS) -o $(TEST_TARGET) $(TEST_OBJS) \
	-lgtest -lgtest_main -pthread

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: all
	./$(TARGET)

test: $(TEST_TARGET)
	./$(TEST_TARGET)

clean:
	rm -f $(OBJS) $(TARGET) $(TEST_OBJS) $(TEST_TARGET)

.PHONY: all run clean test
