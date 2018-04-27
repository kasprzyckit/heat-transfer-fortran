#define ISIZE 3

program heat_transfer
    use gauss_elimination!, only :: gauss_el
    implicit none

    real(kind=8) :: A(ISIZE, ISIZE), X(ISIZE), RES(ISIZE)
    real(kind=8) :: P1, P2, P3, H2
    integer(kind=4) :: I

    H2 = 1.0 / (ISIZE * ISIZE)
    P1 = 1.0 / H2
    P2 = -2.0 / H2

    A = 0
    do I = 1,ISIZE
        A(I, I) = P2
        if (I .NE. 1) then 
            A(I, I - 1) = P1 
        endif
        if (I .NE. ISIZE) then 
            A(I, I + 1) = P1 
        endif
    enddo

    X(:) = 0.0
    X(ISIZE) = 1
    RES(:) = 0.0

    call gauss_el(A, X, ISIZE)
    print *, A
    print *, ""
    print *, X
    print *, ""
    print *, RES

end program heat_transfer