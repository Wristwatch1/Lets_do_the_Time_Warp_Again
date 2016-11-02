var gp_num = gamepad_get_device_count();
for (var i = 0; i < gp_num; i++;)
{
    if (global.gp[i])
    {
        var haxis = gamepad_axis_value(i, gp_axislh);
        var vaxis = gamepad_axis_value(i, gp_axislv);
        if (haxis < -0.5)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
if (gp_num == 0)
{
    return false;
}

