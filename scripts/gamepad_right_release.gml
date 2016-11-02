var gp_num = gamepad_get_device_count();
for (var i = 0; i < gp_num; i++;)
{
    if (global.gp[i])
    {
        var haxis = gamepad_axis_value(i, gp_axislh);
        var vaxis = gamepad_axis_value(i, gp_axislv);
        if (haxis < 0.5) && (right_held == true)
        {
            right_held = false;
            return true;
        }
        if (haxis > 0.5)
        {
            right_held = true;
            return false;
        }
        else
        {
            right_held = false;
            return false;
        }
    }
}
if (gp_num == 0)
{
    return false;
}
