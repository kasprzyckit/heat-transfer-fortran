#if !defined(_KIND)
#define _KIND 16
#endif

program heat_transfer_error
    use fdm, only : heat_transfer
    implicit none

    real(kind = _KIND) :: err
    integer(kind=8) :: N, i
    integer(kind=4) :: l, s
    character(len=10) :: buffer

    call get_command_argument(1, buffer, l, s)
    read(buffer,*) N

    do i = 10, N, 1
        call heat_transfer(i, err)
        print *, err
    enddo

end program heat_transfer_error