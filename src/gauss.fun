test_suite gauss

real(kind = 16) :: A(3, 3), X(3)
integer(kind=8) :: i, N = 3

test gauss_test
  X = 1
  A = 0
  do i=1,N
      A(i, i) = 7
  enddo

  call gauss_elimination(A, X, N)

  do i=1,N
    assert_real_equal(X(i), 1.0/7, 1e-6)
    assert_real_equal(A(i, i), 1, 1e-6)
  enddo
end test

end test_suite