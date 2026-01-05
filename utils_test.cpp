#include <gtest/gtest.h>
#include "utils.h"

TEST(UtilsTest, BasicAssertions)
{
    EXPECT_EQ(3, add(1, 2));
}