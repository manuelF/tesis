#ifndef __MATRIX_H
#define __MATRIX_H

template<typename T>
class Matrix {
    public:
        Matrix(int,int);
        Matrix(const Matrix<T> &);
        ~Matrix(void);
        Matrix & operator=(const Matrix<T> &);

        void fill(T value);
        inline T operator()(int row, int col) const {
            return this->data[this->cols * row + col];
        }

        inline T & ref(int row, int col) {
            return this->data[this->cols * row + col];
        }
        const T * asArray() const;
        const T * row(int) const;

        int nrows() const { return rows; }
        int ncols() const { return cols; }
    private:
        T * data;
        int rows, cols;

        void copy(const Matrix<T> &);
        int bytes() const;
};

#endif
