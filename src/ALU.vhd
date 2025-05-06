----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
 
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
 
entity ALU is

    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;
 
architecture Behavioral of ALU is

    component ripple_adder is
        port(
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC
        );
    end component ripple_adder;
    
    signal w_or : std_logic_vector(7 downto 0);
    signal w_and : std_logic_vector(7 downto 0);
    signal w_sum : std_logic_vector(7 downto 0);
    signal w_B : std_logic_vector(7 downto 0);
    signal w_result : std_logic_vector(7 downto 0);
    signal w_C : std_logic;
    signal w_C2 : std_logic;
 
begin

    w_or <= i_A or i_B;
    w_and <= i_A and i_B;
    w_B <= (not i_B) when (i_op(0) = '1') else i_B;
 
    adder1 : ripple_adder
    port map(
        A => i_A(3 downto 0),
        B => w_B(3 downto 0),
        Cin => i_op(0),
        S => w_sum(3 downto 0),
        Cout => w_C
    );

    adder2 : ripple_adder
    port map(
        A => i_A(7 downto 4),
        B => w_B(7 downto 4),
        Cin => w_C,
        S => w_sum(7 downto 4),
        Cout => w_C2
    );
 
    with i_op select
    w_result <= w_sum when "000",
                w_sum when "001",
                w_and when "010",
                w_or when "011",
                "00000000" when others;
    o_result <= w_result;

    o_flags(3) <= w_result(7);
    o_flags(2) <= not (w_result(0) or w_result(1) or w_result(2) or w_result(3) or w_result(4) or w_result(5) or w_result(6) or w_result(7));
    o_flags(1) <= w_C2 and (not i_op(1));
    o_flags(0) <= (not i_op(1)) and (w_sum(7) xor i_A(7)) and (not (i_op(0) xor i_A(7) xor i_B(7)));
 

end Behavioral;
