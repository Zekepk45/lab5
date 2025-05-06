library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_adder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end ripple_adder;

architecture Behavioral of ripple_adder is

    component full_adder is
        port ( 
           A     : in std_logic;
           B     : in std_logic;
           Cin   : in std_logic;
           S     : out std_logic;
           Cout  : out std_logic
           );
        end component full_adder;
        
        signal w_carry  : STD_LOGIC_VECTOR(7 downto 0); -- for ripple between adders
        signal w_S      : STD_LOGIC_VECTOR(7 downto 0);
       
begin

-- PORT MAPS --------------------
    full_adder_0: full_adder
    port map(
        A     => A(0),
        B     => B(0),
        Cin   => Cin,   -- Directly to input here
        S     => w_S(0),
        Cout  => w_carry(0)
    );

    full_adder_1: full_adder
    port map(
        A     => A(1),
        B     => B(1),
        Cin   => w_carry(0),
        S     => w_S(1),
        Cout  => w_carry(1)
    );
    
    full_adder_2: full_adder
    port map(
        A     => A(2),
        B     => B(2),
        Cin   => w_carry(1),
        S     => w_S(2),
        Cout  => w_carry(2)
    );
    
    full_adder_3: full_adder
    port map(
        A     => A(3),
        B     => B(3),
        Cin   => w_carry(2),
        S     => w_S(3),
        Cout  => w_carry(3)
    );
    
    full_adder_4: full_adder
    port map(
        A     => A(4),
        B     => B(4),
        Cin   => w_carry(3),
        S     => w_S(4),
        Cout  => w_carry(4)
    );
    
    full_adder_5: full_adder
    port map(
        A     => A(5),
        B     => B(5),
        Cin   => w_carry(4),
        S     => w_S(5),
        Cout  => w_carry(5)
    );
    
    full_adder_6: full_adder
    port map(
        A     => A(6),
        B     => B(6),
        Cin   => w_carry(5),
        S     => w_S(6),
        Cout  => w_carry(6)
    );
    
    full_adder_7: full_adder
    port map(
        A     => A(7),
        B     => B(7),
        Cin   => w_carry(6),
        S     => w_S(7),
        Cout  => w_carry(6)
    );

    S <= w_S;
    Cout <= w_carry(7);
end Behavioral;