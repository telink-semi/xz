#
# tuklib_gnu_c_attributes.cmake - Checks for GNU C attributes
#
# Author: Lasse Collin
#
# This file has been put into the public domain.
# You can do whatever you want with this file.
#

include("${CMAKE_CURRENT_LIST_DIR}/tuklib_common.cmake")
include(CheckCSourceCompiles)

# This is a helper function for the actual attribute tests.
function(tuklib_check_attribute CODE RESULT)
    # GCC, Clang, ICC, Solaris Studio, and XLC don't exit with
    # a non-zero exit status if an unknown attribute is provided.
    # They only print a warning. Accept the attribute only if no
    # attribute-related warnings were issued.
    #
    #   - XLC doesn't use the lower-case string "warning".
    #     It might use "WARNING" on z/OS or "(W)" on AIX.
    #     So "warning" isn't checked.
    #
    #   - A few XLC messages use "Attribute" instead of "attribute".
    #
    #   - ICC doesn't use the word "ignored".
    #
    # The problem with this method is that the regex might become
    # outdated with newer compiler versions. Using -Werror would be
    # an alternative but it fails if warnings occur for reasons other
    # than unsupported attribute.
    #
    # The first pattern is for GCC, Solaris Studio, and XLC.
    # The second one is for ICC. Both patterns work with Clang.
    # Matching the leading space or colon reduces chances of
    # matching any unrelated messages.
    check_c_source_compiles("${CODE} int main(void) { return 0; }" "${RESULT}"
                            FAIL_REGEX " [Aa]ttribute .* ignored"
                                       ": unknown attribute")
endfunction()

function(tuklib_check_func_attribute_constructor RESULT)
    tuklib_check_attribute("
            __attribute__((__constructor__))
            void my_constructor_func(void) { return; }
        " "${RESULT}")
endfunction()

function(tuklib_check_func_attribute_ifunc RESULT)
    tuklib_check_attribute("
            static void func(void) { return; }
            static void (*resolve_func(void))(void) { return &func; }
            void func_ifunc(void)
                    __attribute__((__ifunc__(\"resolve_func\")));
        " "${RESULT}")
endfunction()
