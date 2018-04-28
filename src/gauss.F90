#if !defined(_KIND)
#define _KIND 16
#endif

module gauss
        implicit none
        
contains

    subroutine gauss_elimination(A, X, N)
        real(kind=_KIND) :: C
        integer(kind = 8) :: I, J
        integer(kind = 8), intent(in) :: N
        real(kind = _KIND), intent(inout) :: A(N, N), X(N)

        do I = 1,N
            do J = 1,N
                if (I .NE. J) then
                    C = A(I, J) / A(I, I)
                    if (C .NE. 0) then
                        A(:, J) = A(:, J) - C * A(:, I)
                        X(J) = X(J) - C*X(I)
                    endif
                    if (A(I, I) .NE. 1) then
                        X(I) = X(I) / A(I, I)
                        A(:, I) = A(:, I) / A(I, I)
                    endif
                endif
            enddo
        enddo
    end

end module gauss