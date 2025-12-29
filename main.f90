module rk4_module
    implicit none
contains
    ! 微分方程式の定義 (f(t, y))
    subroutine derivatives(t, y, dydt)
        double precision, intent(in) :: t
        double precision, intent(in) :: y(2)
        double precision, intent(out) :: dydt(2)
        dydt(1) = y(2)          ! dx/dt = v
        dydt(2) = -y(1)         ! dv/dt = -x
    end subroutine derivatives

    ! RK4の1ステップ更新サブルーチン
    subroutine rk4_step(t, y, h, n)
        double precision, intent(inout) :: t
        double precision, intent(inout) :: y(n)
        double precision, intent(in) :: h
        integer, intent(in) :: n
        double precision :: k1(n), k2(n), k3(n), k4(n), y_temp(n)

        call derivatives(t, y, k1)
        
        y_temp = y + 0.5d0 * h * k1
        call derivatives(t + 0.5d0 * h, y_temp, k2)
        
        y_temp = y + 0.5d0 * h * k2
        call derivatives(t + 0.5d0 * h, y_temp, k3)
        
        y_temp = y + h * k3
        call derivatives(t + h, y_temp, k4)

        y = y + (h / 6.0d0) * (k1 + 2.0d0 * k2 + 2.0d0 * k3 + k4)
        t = t + h
    end subroutine rk4_step
end module rk4_module

program main
    use rk4_module
    implicit none
    integer, parameter :: n = 2
    integer :: i, steps = 1000
    double precision :: t, y(n), h
    
    ! 初期値設定
    t = 0.0d0
    y = (/1.0d0, 0.0d0/) ! x=1, v=0
    h = 0.01d0           ! 刻み幅

    ! 結果をCSVに出力
    open(10, file='result.csv', status='replace')
    write(10, '(A)') "t,x,v"
    
    do i = 0, steps
        write(10, '(3F12.6)') t, y(1), y(2)
        call rk4_step(t, y, h, n)
    end do
    
    close(10)
    print *, "Simulation finished. Data saved to result.csv"
end program main
