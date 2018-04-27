module gauss_elimination
        implicit none
        
contains

    subroutine gauss_el(A, X, N)
        real(kind=8) :: C
        integer(kind = 4) :: I, J
        integer(kind=4), intent(in) :: N
        real(kind=8), intent(inout) :: A(N, N), X(N)

        do I = 1,N
            do J = 1,N
                if (I .NE. J) then
                    C = A(I, J) / A(I, I)
                    A(:, J) = A(:, J) - C * A(:, I)
                    X(J) = X(J) - C*X(I)
                    X(I) = X(I) / A(I, I)
                    A(:, I) = A(:, I) / A(I, I)
                endif
            enddo
        enddo
    end

end module gauss_elimination