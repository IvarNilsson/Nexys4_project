library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix_type.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_top is
    generic (
        runner_cfg : string
    );
end tb_top;

architecture tb of tb_top is
    constant period : time := 10 ns;

    signal clk_108 : std_logic := '0';
    signal rst     : std_logic := '1';

    signal key_controll : std_logic_vector(3 downto 0);
    signal movment      : std_logic_vector(3 downto 0);

    signal game_tick_edge         : std_logic;
    signal prepare_game_tick_edge : std_logic;
    signal after_game_tick_edge   : std_logic;

    signal add_segment_edge : std_logic := '0';

    signal vga_r  : std_logic_vector(3 downto 0);
    signal vga_g  : std_logic_vector(3 downto 0);
    signal vga_b  : std_logic_vector(3 downto 0);
    signal vga_hs : std_logic;
    signal vga_vs : std_logic;

    signal head_posision_x : unsigned(5 downto 0);
    signal head_posision_y : unsigned(5 downto 0);

    signal end_game_edge : std_logic;

    signal snake_matrix : matrix_32_40 := (others => (others => '0'));

    signal snake_0  : std_logic_vector(39 downto 0);
    signal snake_1  : std_logic_vector(39 downto 0);
    signal snake_2  : std_logic_vector(39 downto 0);
    signal snake_3  : std_logic_vector(39 downto 0);
    signal snake_4  : std_logic_vector(39 downto 0);
    signal snake_5  : std_logic_vector(39 downto 0);
    signal snake_6  : std_logic_vector(39 downto 0);
    signal snake_7  : std_logic_vector(39 downto 0);
    signal snake_8  : std_logic_vector(39 downto 0);
    signal snake_9  : std_logic_vector(39 downto 0);
    signal snake_10 : std_logic_vector(39 downto 0);
    signal snake_11 : std_logic_vector(39 downto 0);
    signal snake_12 : std_logic_vector(39 downto 0);
    signal snake_13 : std_logic_vector(39 downto 0);
    signal snake_14 : std_logic_vector(39 downto 0);
    signal snake_15 : std_logic_vector(39 downto 0);
    signal snake_16 : std_logic_vector(39 downto 0);
    signal snake_17 : std_logic_vector(39 downto 0);
    signal snake_18 : std_logic_vector(39 downto 0);
    signal snake_19 : std_logic_vector(39 downto 0);
    signal snake_20 : std_logic_vector(39 downto 0);
    signal snake_21 : std_logic_vector(39 downto 0);
    signal snake_22 : std_logic_vector(39 downto 0);
    signal snake_23 : std_logic_vector(39 downto 0);
    signal snake_24 : std_logic_vector(39 downto 0);
    signal snake_25 : std_logic_vector(39 downto 0);
    signal snake_26 : std_logic_vector(39 downto 0);
    signal snake_27 : std_logic_vector(39 downto 0);
    signal snake_28 : std_logic_vector(39 downto 0);
    signal snake_29 : std_logic_vector(39 downto 0);
    signal snake_30 : std_logic_vector(39 downto 0);
    signal snake_31 : std_logic_vector(39 downto 0);

begin

    clk_108 <= not clk_108 after period / 2;
    rst     <= '0' after period * 5;

    process (all)
    begin
        if (add_segment_edge = '1') then
            add_segment_edge <= not add_segment_edge after period;
        else
            add_segment_edge <= not add_segment_edge after period * 400;
        end if;
    end process;

    snake_0  <= snake_matrix(0);
    snake_1  <= snake_matrix(1);
    snake_2  <= snake_matrix(2);
    snake_3  <= snake_matrix(3);
    snake_4  <= snake_matrix(4);
    snake_5  <= snake_matrix(5);
    snake_6  <= snake_matrix(6);
    snake_7  <= snake_matrix(7);
    snake_8  <= snake_matrix(8);
    snake_9  <= snake_matrix(9);
    snake_10 <= snake_matrix(10);
    snake_11 <= snake_matrix(11);
    snake_12 <= snake_matrix(12);
    snake_13 <= snake_matrix(13);
    snake_14 <= snake_matrix(14);
    snake_15 <= snake_matrix(15);
    snake_16 <= snake_matrix(16);
    snake_17 <= snake_matrix(17);
    snake_18 <= snake_matrix(18);
    snake_19 <= snake_matrix(19);
    snake_20 <= snake_matrix(20);
    snake_21 <= snake_matrix(21);
    snake_22 <= snake_matrix(22);
    snake_23 <= snake_matrix(23);
    snake_24 <= snake_matrix(24);
    snake_25 <= snake_matrix(25);
    snake_26 <= snake_matrix(26);
    snake_27 <= snake_matrix(27);
    snake_28 <= snake_matrix(28);
    snake_29 <= snake_matrix(29);
    snake_30 <= snake_matrix(30);
    snake_31 <= snake_matrix(31);
    kb_ctrl_stimuli : entity work.kb_ctrl_stimuli
        port map(
            clk          => clk_108,
            rst          => rst,
            key_controll => key_controll
        );

    kb_game_tick : entity work.kb_game_tick
        port map(
            clk                    => clk_108,
            rst                    => rst,
            prepare_game_tick_edge => prepare_game_tick_edge,
            key_controll           => key_controll,
            movment                => movment
        );

    game_tick_gen : entity work.game_tick_gen
        generic map(
            countWidth => 3
        )
        port map(
            clk                    => clk_108,
            rst                    => rst,
            prepare_game_tick_edge => prepare_game_tick_edge,
            game_tick_edge         => game_tick_edge,
            after_game_tick_edge   => after_game_tick_edge
        );

    segments : entity work.segments
        port map(
            clk                  => clk_108,
            rst                  => rst,
            after_game_tick_edge => after_game_tick_edge,
            movment              => movment,
            add_segment_edge     => add_segment_edge,
            head_posision_x      => head_posision_x,
            head_posision_y      => head_posision_y,
            snake_matrix         => snake_matrix
        );

    segments_colision : entity work.segment_colision
        port map(
            clk             => clk_108,
            rst             => rst,
            game_tick_edge  => game_tick_edge,
            movment         => movment,
            snake_matrix    => snake_matrix,
            head_posision_x => head_posision_x,
            head_posision_y => head_posision_y,
            --apple_posision_x => apple_posision_x,
            --apple_posision_y => apple_posision_y,
            --add_segment_edge => add_segment_edge,
            end_game_edge => end_game_edge
        );

    vga_controller : entity work.vga_controller
        port map(
            clk_108      => clk_108,
            rst          => rst,
            snake_matrix => snake_matrix,
            vga_r        => vga_r,
            vga_g        => vga_g,
            vga_b        => vga_b,
            vga_hs       => vga_hs,
            vga_vs       => vga_vs
        );
    main_p : process
    begin
        test_runner_setup(runner, runner_cfg);
        while test_suite loop
            if run("wave") then

                wait for 350000 ns;

            elsif run("long") then

                wait for 350000 ns;

            elsif run("auto") then

                wait for 350000 ns;

                --check(counter_mealy = expected_res, "mealy wrong expected: " & to_string(expected_res) & "   got: " & to_string(counter_mealy), warning);
                --check(counter_moore = expected_res, "moore wrong expected: " & to_string(expected_res) & "   got: " & to_string(counter_moore), warning);
                info("test done");
            end if;
        end loop;

        test_runner_cleanup(runner);
    end process;

    test_runner_watchdog(runner, 100 ms);

end architecture;
