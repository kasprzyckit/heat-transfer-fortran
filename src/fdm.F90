#if !defined(_KIND)
#define _KIND 16
#endif

module fdm
    implicit none

    contains

    subroutine heat_transfer(N, err)
        use gauss, only : gauss_elimination

        integer(kind=8), intent(in) :: N
        real(kind = _KIND), intent(inout) :: err
        real(kind = _KIND), allocatable :: A(:, :), X(:)
        real(kind = _KIND) :: P1, P2, h2
        integer(kind=8) :: i

        allocate(A(N, N))
        allocate(X(N))

        h2 = 1.0 / real(N * N)
        P1 = 1.0 / h2
        P2 = -2.0 / h2

        A = 0
        do i = 1,N
            A(i, i) = P2
            if (i .NE. 1) then 
                A(i, i - 1) = P1 
            endif
            if (i .NE. N) then 
                A(i, i + 1) = P1 
            endif
        enddo

        X(:) = 0.0
        X(N) = 1

        call gauss_elimination(A, X, N)
        X = X * real(N * (N + 1) * (-1))
        
        err = 0
        do i = 1,N
            err = err + abs(X(i) - real(i)/real(N))
        enddo

        err = err / N

        deallocate(A)
        deallocate(X)

    end

end module fdm