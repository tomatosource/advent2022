def main():
    print(sum(sorted([sum([int(y or '0') for y in x.split('\n')]) for x in open('./input.txt').read().split('\n\n')])[-3:]))

if __name__ == "__main__":
    main()
